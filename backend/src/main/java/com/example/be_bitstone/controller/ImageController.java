package com.example.be_bitstone.controller;

import com.example.be_bitstone.dto.GpsDto;
import com.example.be_bitstone.dto.UserTokenDto;
import com.example.be_bitstone.handlers.ImageHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/image")
public class ImageController {
    private final ObjectMapper objectMapper = new ObjectMapper();
    @Autowired
    private ImageHandler imageHandler;

    @PostMapping(value = "/send", consumes = "multipart/form-data")
    ResponseEntity<String> uploadNewImage(HttpServletRequest request, @RequestParam("image") MultipartFile image, @RequestParam("gpsData") String jsonGpsData){

        Long userId = ((UserTokenDto)request.getAttribute("authData")).getId();

        GpsDto gpsData = new GpsDto(200.0, 200.0);
        try {
            gpsData = objectMapper.readValue(jsonGpsData, GpsDto.class);
        } catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Error processing the gps data!", HttpStatus.BAD_REQUEST);
        }

        return imageHandler.uploadImageForProcessing(image, userId, gpsData);
    }

    @GetMapping("/detections/{classId}")
    public ResponseEntity<?> getImagesWithDetectionClassId(@PathVariable Integer classId){
        return imageHandler.getImagesWithDetectionClassId(classId);
    }
}
