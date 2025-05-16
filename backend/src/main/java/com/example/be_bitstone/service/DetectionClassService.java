package com.example.be_bitstone.service;

import com.example.be_bitstone.entity.DetectionClass;
import com.example.be_bitstone.repository.DetectionClassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DetectionClassService {
    @Autowired
    private DetectionClassRepository detectionClassRepository;

    public List<DetectionClass> findAll() {
        return detectionClassRepository.findAll();
    }
}
