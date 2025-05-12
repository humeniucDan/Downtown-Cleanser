package com.example.be_bitstone.utils;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;
import org.springframework.web.multipart.MultipartFile;

public class ImageResizer {
    public static byte[] resizeMultipartFile(MultipartFile file,  Integer size) throws IOException {
        return resizeMultipartFile(file, size, size);
    }

    public static byte[] resizeMultipartFile(MultipartFile file,  Integer sizeW, Integer sizeH) throws IOException {
        BufferedImage original = ImageIO.read(file.getInputStream());
        if (original == null) {
            throw new IOException("Invalid image file: " + file.getOriginalFilename());
        }

        Image tmp = original.getScaledInstance(sizeW, sizeH, Image.SCALE_SMOOTH);
        BufferedImage resized = new BufferedImage(sizeW, sizeH, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = resized.createGraphics();
        g2d.drawImage(tmp, 0, 0, null);
        g2d.dispose();

        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            ImageIO.write(resized, "png", baos);
            return baos.toByteArray();
        }
    }
}