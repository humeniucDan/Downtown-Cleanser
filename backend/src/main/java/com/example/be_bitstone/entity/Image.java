package com.example.be_bitstone.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "images")
public class Image {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "posted_at", nullable = false)
    private Date postedAt;

    @Column(name = "finished_processing", nullable = false)
    private boolean finishedProcessing;

    @Column(name = "raw_image_url")
    private String rawImageUrl;

    @Column(name = "annotated_image_url")
    private String annotatedImageUrl;

    @Column(name = "lat")
    private Float lat;

    @Column(name = "lng")
    private Float lng;

    @Column(name = "file_name")
    private String fileName;
}
