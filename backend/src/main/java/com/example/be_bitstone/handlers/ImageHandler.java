package com.example.be_bitstone.handlers;

import com.example.be_bitstone.dto.GpsDto;
import com.example.be_bitstone.entity.Image;
import com.example.be_bitstone.entity.User;
import com.example.be_bitstone.service.FilebaseService;
import com.example.be_bitstone.service.ImageService;
import com.example.be_bitstone.service.RedisProducerService;
import com.example.be_bitstone.utils.FileHasher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Service
public class ImageHandler {
    @Autowired
    private FilebaseService filebaseService;
    @Autowired
    private RedisProducerService redisProducerService;

    @Autowired
    private ImageService imageService;

    public ResponseEntity<String> uploadImageForProcessing(MultipartFile image, Long userId, GpsDto gpsData){
        String fileHash = FileHasher.hashMultipartFile(image) + ".png";
        String rawFileUrl = "https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png";
        try{
            rawFileUrl = filebaseService.uploadFile(image, fileHash);
        } catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Uploading file name failed!", HttpStatus.BAD_REQUEST);
        }

        Image newImage = new Image();
        newImage.setFileName(fileHash);
        newImage.setRawImageUrl(rawFileUrl);
        newImage.setLat(gpsData.getLat());
        newImage.setLng(gpsData.getLng());
        newImage.setPostedAt(new Date());
        newImage.setPostedBy(userId);

        Image newInsertedImage = imageService.save(newImage);

        /// TODO: handle failure of of enqueueing; probably by deleting teh entry or retying
        if(!redisProducerService.enqueue(newInsertedImage.getId() + ":" + fileHash)){
            System.out.println("Enqueueing file name failed!");
            return new ResponseEntity<>("Sending file name failed!", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>("Uploaded and send file successfully!", HttpStatus.OK);
    }
}
