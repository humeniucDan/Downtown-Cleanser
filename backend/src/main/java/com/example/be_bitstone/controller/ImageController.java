package com.example.be_bitstone.controller;

import com.example.be_bitstone.handlers.ImageHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/image")
public class ImageController {
    @Autowired
    private ImageHandler imageHandler;

    @PostMapping(value = "/send", consumes = "multipart/form-data")
    ResponseEntity<String> testPushToQueue(@RequestParam("image") MultipartFile image){
        imageHandler.uploadImageForProcessing(image);
        return new ResponseEntity<>("ok", HttpStatus.OK);
    }
}
