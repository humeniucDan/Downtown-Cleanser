package com.example.be_bitstone.service;

import com.example.be_bitstone.entity.Detection;
import com.example.be_bitstone.repository.DetectionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;


@Service
public class DetectionService {
    @Autowired
    private DetectionRepository detectionRepository;

    public Detection save(Detection detection){
        return detectionRepository.save(detection);
    }

    public Optional<Detection> findById(Long id){ return detectionRepository.findById(id);}

    public Optional<Detection> markDetectionResolved(Long id) {
        Optional<Detection> optDetection = detectionRepository.findById(id);
        if(optDetection.isEmpty()){
            return optDetection;
        }

        Detection detection = optDetection.get();
        detection.setIsResolved(true);
        detection.setResolvedAt(new Date());
        ///  TODO: also add the resolvedBy field in order to track reps work
        detectionRepository.save(detection);

        return Optional.of(detection);
    }
}
