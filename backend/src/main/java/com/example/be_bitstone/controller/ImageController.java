package com.example.be_bitstone.controller;

import com.example.be_bitstone.dto.GpsDto;
import com.example.be_bitstone.handlers.ImageHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
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
    private final ObjectMapper objectMapper = new ObjectMapper();
    @Autowired
    private ImageHandler imageHandler;

    @PostMapping(value = "/send", consumes = "multipart/form-data")
    ResponseEntity<String> testPushToQueue(@RequestParam("image") MultipartFile image, @RequestParam("gpsData") String jsonGpsData){
        /// TODO: get actual id of the user that made the request
        Long userId = 1L;
        /// -----------------------------------------------------

        GpsDto gpsData = new GpsDto(200.0, 200.0);
        try {
            gpsData = objectMapper.readValue(jsonGpsData, GpsDto.class);
        } catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Error processing the gps data!", HttpStatus.BAD_REQUEST);
        }

        return imageHandler.uploadImageForProcessing(image, userId, gpsData);
    }
}
