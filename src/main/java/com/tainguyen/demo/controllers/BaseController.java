package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.User;
import com.tainguyen.demo.repository.UserGet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

@Controller
public class BaseController {

	@Autowired
	UserGet userRepository;

	public String getCurrentAuth() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			String currentUserName = authentication.getName();
			return currentUserName;
		}
		return null;
	}

	public User getCurrentUser() {
		String currentUserName = getCurrentAuth();
		return userRepository.getUserByUserName(currentUserName);
	}
}
