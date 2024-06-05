package com.gdu.myapp.service;

import org.springframework.ui.Model;

import com.gdu.myapp.dto.EmpDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface EmpService {
	void signin(HttpServletRequest request, HttpServletResponse response);
	void loadEmpList(HttpServletRequest request, Model model);
	void registerEmp(HttpServletRequest request, HttpServletResponse response);
	EmpDto getEmpDetail(String empCode);
//	int editEmployee(EmpDto emp);
}
