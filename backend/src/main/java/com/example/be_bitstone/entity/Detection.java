package com.example.be_bitstone.entity;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Detection {
    int x1, y1, x2, y2, classId;
}
