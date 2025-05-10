package com.example.be_bitstone.controller;

import com.example.be_bitstone.dto.UserTokenDto;
import com.example.be_bitstone.entity.User;
import com.example.be_bitstone.handlers.UserHandler;
import com.example.be_bitstone.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserHandler userHandler;

    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable Long id){
        /// TODO: only allow this unless an admin make the request or public profiles for something like a leaderboard
        /// basically at least check if the admin flag in the token data (authDto) is true, needs to be added in the token data
        /// might as well refactor the token maybe with a better dto
        /// or maybe by breaking this into multiple microservices
        return userHandler.getById(id);
    }

    @GetMapping
    public ResponseEntity<?> getAllUsers(){
        /// TODO: only allow this unless an admin make the request or public profiles for something like a leaderboard
        /// basically at least check if the admin flag in the token data (authDto) is true, needs to be added in the token data
        /// might as well refactor the token maybe with a better dto
        /// or maybe by breaking this into multiple microservices
        return userHandler.getAll();
    }

    @GetMapping("/id")
    public ResponseEntity<User> getUserByToken(HttpServletRequest req){
        Long userId = ((UserTokenDto)req.getAttribute("authData")).getId();
        return new ResponseEntity<>(null, HttpStatus.OK);
    }
}
