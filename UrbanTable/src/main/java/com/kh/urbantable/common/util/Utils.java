package com.kh.urbantable.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Random;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;

import com.kh.urbantable.message.APIInit;
import com.kh.urbantable.message.vo.Message;
import com.kh.urbantable.message.vo.MessageModel;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class Utils {
	
	private static String KAKAO_API = "7d4c5930335ffbc5656a72e6dceeff50";
	
	//주소로 좌표찾기
	public static HashMap<String, Double> getLocation(String address){
		
		HashMap<String, Double> map = new HashMap<String, Double>();
		
		HttpsURLConnection conn = null;
		
		try {
			
			StringBuilder urlBuilder = new StringBuilder("https://dapi.kakao.com/v2/local/search/address.json");/* URL */
			urlBuilder.append("?" + URLEncoder.encode("query", "UTF-8") + "=" + URLEncoder.encode(address, "UTF-8")); /* 검색 키워드 */
			urlBuilder.append("&" + URLEncoder.encode("size", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
			
			URL url = new URL(urlBuilder.toString());
            
			conn = (HttpsURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			conn.setRequestProperty("Authorization", "KakaoAK "+KAKAO_API);

			BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			
			JSONObject jsonObject = new JSONObject(sb.toString());
			
			JSONArray jsonArray = jsonObject.getJSONArray("documents");
		
			jsonObject = jsonArray.getJSONObject(0);			
			
			map.put("x", jsonObject.getDouble("x"));
			map.put("y", jsonObject.getDouble("y"));
			
		}catch(Exception e) {
			return null;
		}
		
		return map;
	}
	
	//좌표 거리 차이
	public static double distance(HashMap<String, Double> loc1, HashMap<String, Double> loc2, String unit) {
        
        double theta = loc1.get("x") - loc2.get("x");
        double dist = Math.sin(deg2rad(loc1.get("y"))) * Math.sin(deg2rad(loc2.get("y"))) + Math.cos(deg2rad(loc1.get("y"))) * Math.cos(deg2rad(loc2.get("y"))) * Math.cos(deg2rad(theta));
         
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515;
         
        if (unit == "kilometer") {
            dist = dist * 1.609344;
        } else if(unit == "meter"){
            dist = dist * 1609.344;
        }
 
        return (dist);
    }
     
 
    // This function converts decimal degrees to radians
    private static double deg2rad(double deg) {
        return (deg * Math.PI / 180.0);
    }
     
    // This function converts radians to decimal degrees
    private static double rad2deg(double rad) {
        return (rad * 180 / Math.PI);
    }
    
    // 메세지 보내기 
    public static void sendMessage(Message message) {
    	Call<MessageModel> api = APIInit.getAPI().sendMessage(APIInit.getHeaders(), message);
        api.enqueue(new Callback<MessageModel>() {
        	@Override
            public void onResponse(Call<MessageModel> call, Response<MessageModel> response) {
                // 성공 시 200이 출력됩니다.
                if (response.isSuccessful()) {
                	
                } else {
                	
                    try {
                        System.out.println(response.errorBody().string());
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }

            @Override
            public void onFailure(Call<MessageModel> call, Throwable throwable) {
                throwable.printStackTrace();
            }
        });
    }
    
    //랜덤키 생성
    public static String getKey(int size) {
      Random ran = new Random();
      StringBuffer sb = new StringBuffer();
      int num = 0;
      do {
        num = ran.nextInt(75) + 48;
        if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
          sb.append((char) num);
        } else {
          continue;
        }
      } while (sb.length() < size);
      return sb.toString();
    }
    
    //쿠키값 가져오기
    public static String getCookies(HttpServletRequest request, String cookieName) {
        String value = null;
        Cookie[] cookies = request.getCookies();
        if(cookies == null) return value;
        for (Cookie cookie : cookies) {
          if (cookie.getName().equals(cookieName)) {
            value = cookie.getValue();
            break;
          }
        }
        return value;
      }


}
