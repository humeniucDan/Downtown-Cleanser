package com.example.be_bitstone.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/ver")
public class VersionController {
    @GetMapping()
    public ResponseEntity<?> index(HttpServletRequest request) {
        String rspStr = "v0.0.3\n";
        return new ResponseEntity<>(rspStr, HttpStatus.OK);
    }
}
