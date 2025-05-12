package com.example.be_bitstone.handlers;

import com.example.be_bitstone.entity.Authority;
import com.example.be_bitstone.repository.AuthorityRepository;
import com.example.be_bitstone.service.AuthorityService;
import com.example.be_bitstone.utils.CodeGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
public class AuthorityHandler {
    @Autowired
    private AuthorityService authorityService;

    public ResponseEntity<?> registerAuthority(Authority authority){
        authority.setRepCode(CodeGenerator.generateCode());
        Authority insertedAuthority = authorityService.save(authority);
        return new ResponseEntity<>(insertedAuthority, HttpStatus.OK);
    }
}
