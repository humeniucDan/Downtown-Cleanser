package com.example.be_bitstone.controller;

import com.example.be_bitstone.dto.UserAuthDto;
import com.example.be_bitstone.entity.User;
import com.example.be_bitstone.handlers.AuthHandler;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
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
    @PostMapping("/login")
    public ResponseEntity<String> login(HttpServletResponse rsp, @RequestBody UserAuthDto userAuthData){
        return authHandler.login(rsp, userAuthData);
    }

    @PostMapping("/signup")
    public ResponseEntity<String> signup(@RequestBody User user){
        return (ResponseEntity<String>) authHandler.signup(user);
    }
}
