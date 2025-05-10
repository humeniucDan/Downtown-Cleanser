package com.example.be_bitstone.controller;

import com.example.be_bitstone.handlers.DetectionHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/detections")
public class DetectionController {
    @Autowired
    private DetectionHandler detectionHandler;

//    @PutMapping("/{id}")
//    public ResponseEntity<?> updateDetection(@PathVariable Long id){
//        return detectionHandler.
//    }
}
