package com.kh.urbantable.message;

import java.nio.charset.StandardCharsets;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.UUID;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.security.crypto.codec.Hex;

import okhttp3.OkHttpClient;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.converter.scalars.ScalarsConverterFactory;

public class APIInit {
    private static Retrofit retrofit;
    private static SolapiMsgV4 messageService;

    public static String getHeaders() {
        try {
            String apiKey = "NCSUNXJLDDWYPWAP";
            String apiSecret = "2VEE5QMD9TC0RPYREPJZVY7ONYJIA117";
            String salt = UUID.randomUUID().toString().replaceAll("-", "");
            String date = ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toString().split("\\[")[0];

            Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
            SecretKeySpec secret_key = new SecretKeySpec(apiSecret.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            sha256_HMAC.init(secret_key);
            String signature = new String(Hex.encode(sha256_HMAC.doFinal((date + salt).getBytes(StandardCharsets.UTF_8))));
            return "HMAC-SHA256 ApiKey=" + apiKey + ", Date=" + date + ", salt=" + salt + ", signature=" + signature;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static SolapiMsgV4 getAPI() {
        if (messageService == null) {
            setRetrofit();
            messageService = retrofit.create(SolapiMsgV4.class);
        }
        return messageService;
    }

    static void setRetrofit() {
        OkHttpClient client = new OkHttpClient.Builder()
                .build();
        retrofit = new Retrofit.Builder()
                .baseUrl("https://api.solapi.com/")
                .addConverterFactory(ScalarsConverterFactory.create())
                .addConverterFactory(GsonConverterFactory.create())
                .client(client)
                .build();
    }
}