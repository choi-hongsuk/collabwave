package com.gdu.myapp.utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MyFileUtils {
	@Value("${service.file.uploadurl}")
	public String UP_DIR;

  // 현재 날짜
  public static final LocalDate TODAY = LocalDate.now();
  
  // 업로드 경로 반환
  public String getUploadPath() {
	  return UP_DIR + DateTimeFormatter.ofPattern("yyyy/MM/dd").format(TODAY);
    //return UP_DIR + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
    //return "/upload" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
  }
  
  // 저장될 파일명 반환
  public String getFilesystemName(String originalFilename) {
    String extName = null;
    if(originalFilename.endsWith(".tar.gz")) {
      extName = ".tar.gz";
    } else {
      extName = originalFilename.substring(originalFilename.lastIndexOf("."));
    }
    return UUID.randomUUID().toString().replace("-", "") + extName;
  }
  
  // 임시 파일 경로 반환
  public String getTempPath() {
    return "/temporary";
  }
  
  // 임시 파일 이름 반환 (확장자 제외)
  public String getTempFilename() {
    return System.currentTimeMillis() + "";
  }
  
  // 작성시 사용된 이미지가 저장될 경로 반환하기
  public String getImageUploadPath() {
    return "/post" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
  }
  
  // 이미지가 저장된 어제 경로를 반환
  public String getImageUploadPathInYesterday() {
    return "/post" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY.minusDays(1));
  }
  
}