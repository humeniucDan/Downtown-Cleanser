package com.example.be_bitstone.handlers;

import com.example.be_bitstone.dto.UserLoginDto;
import com.example.be_bitstone.dto.UserSignupDto;
import com.example.be_bitstone.entity.Authority;
import com.example.be_bitstone.entity.User;
import com.example.be_bitstone.service.AuthorityService;
import com.example.be_bitstone.service.UserService;
import com.example.be_bitstone.utils.JWTService.JWTGenerator;
import com.example.be_bitstone.utils.JWTService.JWTParser;
import com.example.be_bitstone.utils.PasswordHasher;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Component
public class AuthHandler {
    @Autowired
    private UserService userService;
    @Autowired
    private AuthorityService authorityService;
    @Autowired
    private PasswordHasher passwordHasher;
    @Autowired
    private JWTGenerator jwtGenerator;

    public ResponseEntity<String> login(HttpServletResponse rsp, UserLoginDto userAuthData){
        Optional<User> optUser = userService.findByEmail(userAuthData.getEmail());
        if(optUser.isEmpty()){
            return new ResponseEntity<>("No such user!" , HttpStatus.BAD_REQUEST);
        }
        User existingUser = optUser.get();

        if(!passwordHasher.isPasswordMatch(userAuthData.getPassword(), existingUser.getPassword())){ // daca NU se potrivesc parolele
            return new ResponseEntity<>("No such password!" , HttpStatus.BAD_REQUEST);
        }

        try {
            String token = jwtGenerator.generateToken(existingUser);
            Cookie cookie = new Cookie("jwToken", token);
            cookie.setPath("/");
            cookie.setHttpOnly(true);
            cookie.setSecure(true); // Required when SameSite=None

            // Add manually SameSite attribute
            rsp.setHeader("Set-Cookie",
                    String.format("%s=%s; Path=/; HttpOnly; Secure; SameSite=None;",
                            cookie.getName(), cookie.getValue()));

            rsp.addCookie(cookie);

            ResponseEntity<String> retRsp = new ResponseEntity<>(token, HttpStatus.OK);
            return retRsp;
        } catch (Exception e){
            System.out.println(e.getStackTrace());
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Error logging in!", HttpStatus.BAD_REQUEST);
        }
    }

    public ResponseEntity<?> signup(UserSignupDto userSignupData){
        try {
            userSignupData.setPassword(passwordHasher.hashPassword(userSignupData.getPassword())); // make this not be a one-liner

            User newUser = new User();
            newUser.setEmail(userSignupData.getEmail());
            newUser.setPassword(userSignupData.getPassword());
            newUser.setFullName(userSignupData.getFullName());

            if(userSignupData.getRepCode() == null){
                return new ResponseEntity<>(userService.save(newUser), HttpStatus.OK);
            }

            Optional<Authority> optAuthority = authorityService.findByRepCode(userSignupData.getRepCode());
            if(optAuthority.isPresent()){
                newUser.setIsRep(true);
                newUser.setRepAuthorityId(optAuthority.get().getId());
            } else {
                return new ResponseEntity<>("No such authority!", HttpStatus.BAD_REQUEST);
            }

            return new ResponseEntity<>(userService.save(newUser), HttpStatus.OK);
        } catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Error creating new user!", HttpStatus.OK);
        }
    }
}
