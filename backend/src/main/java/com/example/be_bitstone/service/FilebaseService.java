package com.example.be_bitstone.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;

import java.io.IOException;
import java.util.Map;

@Service
public class FilebaseService {
    @Value("${filebase.endpoint}")
    private String filebaseEndpoint;
    @Value("${filebase.bucket.name}")
    private String bucketName;
    @Value("${filebase.gateway.name}")
    private String gatewayNme;
    @Autowired
    private S3Client s3Client;

    public String uploadFile(MultipartFile file, String uploadName) {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("File name cannot be empty.");
        }

        String fileName = file.getOriginalFilename();
        if (fileName == null || fileName.isEmpty()) {
            throw new IllegalArgumentException("File name cannot be empty.");
        }

        try{
            return uploadFile(file.getBytes(), uploadName);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }

    public String uploadFile(byte[] file, String uploadName) {

        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucketName)
                .key(uploadName)
                .build();

        String cid = "";

        PutObjectResponse putResp = s3Client.putObject(putObjectRequest, RequestBody.fromBytes(file));
        System.out.println("File uploaded successfully.");

        HeadObjectRequest headRequest = HeadObjectRequest.builder()
                .bucket(bucketName)
                .key(uploadName)
                .build();

        HeadObjectResponse headResponse = s3Client.headObject(headRequest);
        Map<String, String> userMetadata = headResponse.metadata();

        cid = userMetadata.get("cid");

        if (cid == null || cid.isEmpty()) {
            System.out.println("CID not found in metadata. Available metadata:");
            userMetadata.forEach((key, value) -> System.out.println(key + " : " + value));
        } else {
            System.out.println("File Base CID: " + cid);
        }

        return gatewayNme + cid;
    }
}
