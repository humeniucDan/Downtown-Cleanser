package com.example.be_bitstone.handlers;

import com.example.be_bitstone.dto.UserAuthDto;
import com.example.be_bitstone.entity.User;
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

import java.util.Optional;

@Component
public class AuthHandler {
    @Autowired
    private UserService userService;
    @Autowired
    private PasswordHasher passwordHasher;
    @Autowired
    private JWTGenerator jwtGenerator;
    @Autowired
    private JWTParser jwtParser;

    public ResponseEntity<String> login(HttpServletResponse rsp, UserAuthDto userAuthData){
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
            rsp.addCookie(new Cookie("jwToken", token));
            return new ResponseEntity<>(token, HttpStatus.OK);
        } catch (Exception e){
            return new ResponseEntity<>("Error logging in!", HttpStatus.BAD_REQUEST);
        }
    }

    public ResponseEntity<?> signup(User user){
        try {
            user.setPassword(passwordHasher.hashPassword(user.getPassword())); // make this not be a one-liner
            return new ResponseEntity<>(userService.save(user), HttpStatus.OK);
        } catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Error creating new user!", HttpStatus.OK);
        }
    }
}
