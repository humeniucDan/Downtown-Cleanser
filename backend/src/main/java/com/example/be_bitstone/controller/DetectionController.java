package com.example.be_bitstone.controller;

import com.example.be_bitstone.dto.UserTokenDto;
import com.example.be_bitstone.handlers.DetectionHandler;
import com.example.be_bitstone.service.DetectionClassService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/detections")
public class DetectionController {
    @Autowired
    private DetectionHandler detectionHandler;
    @Autowired
    private DetectionClassService detectionClassService;

    @PutMapping("/resolved/{id}")
    public ResponseEntity<?> markDetectionResolved(HttpServletRequest req, @PathVariable Long id){
        return detectionHandler.markDetectionResolved((UserTokenDto)req.getAttribute("authData"), id);
    }

    @GetMapping("/classes")
    public ResponseEntity<?> findAll() {
        return new ResponseEntity<>(detectionClassService.findAll(), HttpStatus.OK);
    }
}
