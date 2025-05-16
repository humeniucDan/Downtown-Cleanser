package com.example.be_bitstone.utils;

import java.util.concurrent.ThreadLocalRandom;

public class CodeGenerator {
    public static String generateCode(){
        StringBuilder code = new StringBuilder();

        for (int i = 0; i < 3; i++) {
            int rand4 = ThreadLocalRandom.current().nextInt(1000, 10000);
            code.append(rand4);
            code.append("-");
        }
        int rand4 = ThreadLocalRandom.current().nextInt(1000, 10000);
        code.append(rand4);

        return code.toString();
    }
}
