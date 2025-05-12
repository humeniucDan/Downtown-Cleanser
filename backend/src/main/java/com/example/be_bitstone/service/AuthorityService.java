package com.example.be_bitstone.service;

import com.example.be_bitstone.entity.Authority;
import com.example.be_bitstone.repository.AuthorityRepository;
import com.example.be_bitstone.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AuthorityService {
    @Autowired
    private AuthorityRepository authorityRepository;

    public Optional<Authority> findByRepCode(String repCode){
        return authorityRepository.findByRepCode(repCode);
    }

    public List<Authority> findAll(){
        return authorityRepository.findAll();
    }

    public Authority save(Authority authority){
        return authorityRepository.save(authority);
    }
}
