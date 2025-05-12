package com.example.be_bitstone.controller;

import com.example.be_bitstone.dto.UserLoginDto;
import com.example.be_bitstone.dto.UserSignupDto;
import com.example.be_bitstone.entity.Authority;
import com.example.be_bitstone.entity.User;
import com.example.be_bitstone.handlers.AuthHandler;
import com.example.be_bitstone.handlers.AuthorityHandler;
import com.example.be_bitstone.service.AuthorityService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("")
public class AuthController {
    @Autowired
    private AuthHandler authHandler;
    @Autowired
    private AuthorityHandler authorityHandler;

    @PostMapping("/login")
    public ResponseEntity<String> login(HttpServletResponse rsp, @RequestBody UserLoginDto userAuthData){
        return authHandler.login(rsp, userAuthData);
    }

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody UserSignupDto user){
        return authHandler.signup(user);
    }
    @PostMapping ("authority/register")
    public ResponseEntity<?> registerAuthority(@RequestBody Authority authority){
        return authorityHandler.registerAuthority(authority);
    }
}
