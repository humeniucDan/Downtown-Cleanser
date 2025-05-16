package com.example.be_bitstone.controller;

import com.example.be_bitstone.dto.AuthorityAuthData;
import com.example.be_bitstone.entity.Authority;
import com.example.be_bitstone.handlers.AuthorityHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/authority")
public class AuthorityController {
    @Autowired
    private AuthorityHandler authorityHandler;

    @PostMapping("/register")
    public ResponseEntity<?> registerAuthority(@RequestBody Authority authority){
        return authorityHandler.registerAuthority(authority);
    }

    @PostMapping ("/code")
    public ResponseEntity<?> getAuthorityCode(@RequestBody AuthorityAuthData authorityAuthData){
        return authorityHandler.getAuthorityCode(authorityAuthData);
    }
}
