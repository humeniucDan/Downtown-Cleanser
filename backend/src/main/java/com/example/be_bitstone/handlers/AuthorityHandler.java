package com.example.be_bitstone.handlers;

import com.example.be_bitstone.dto.AuthorityAuthData;
import com.example.be_bitstone.entity.Authority;
import com.example.be_bitstone.service.AuthorityService;
import com.example.be_bitstone.utils.CodeGenerator;
import com.example.be_bitstone.utils.PasswordHasher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class AuthorityHandler {
    @Autowired
    private PasswordHasher passwordHasher;

    @Autowired
    private AuthorityService authorityService;

    public ResponseEntity<?> registerAuthority(Authority authority){
        /// Todo: somehow validate cui to allow registration

        authority.setRepCode(CodeGenerator.generateCode());
        try {
            authority.setPassword(passwordHasher.hashPassword(authority.getPassword()));
        } catch (Exception e) {
            e.getMessage();
        }

//        Authority insertedAuthority = authorityService.save(authority);
        return new ResponseEntity<>(
                authorityService.save(authority),
                HttpStatus.OK
        );
    }

    public ResponseEntity<?> getAuthorityCode(AuthorityAuthData authData) {
        Optional<Authority> optAuthority = authorityService.findByCui(authData.getCui());
        if(optAuthority.isEmpty()){
            return new ResponseEntity<>("No such authority!", HttpStatus.BAD_REQUEST);
        }
        Authority authority = optAuthority.get();
        passwordHasher.isPasswordMatch(authData.getPassword(), authority.getPassword());

        return new ResponseEntity<>(authority.getRepCode(), HttpStatus.OK);
    }
}
