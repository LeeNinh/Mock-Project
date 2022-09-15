package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.User;
import com.tainguyen.demo.repository.UserGet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.tainguyen.demo.controllers.utilities.Utility.*;

@Controller
@RequestMapping(value = "/account")
public class AccountController {

    @Autowired
    private AuthenticationManager authManager;

    @Autowired
    private UserGet userGet;

    @Autowired
    private PasswordEncoder encoder;

    @GetMapping("/loginAdminForm")
    public String adminLogin() {
        return "/admin/login";
    }

    @GetMapping("/loginForm")
    public String login() {
        return "login";
    }

    @GetMapping("/registerForm")
    public String register() {
        return "register";
    }

    @PostMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        User users;
        HttpSession session = request.getSession();

        String username1 = request.getParameter("username");
        String password1 = request.getParameter("pass");

        try {
            UsernamePasswordAuthenticationToken authReq
                    = new UsernamePasswordAuthenticationToken(username1, password1);
            Authentication auth = authManager.authenticate(authReq);

            SecurityContext sc = SecurityContextHolder.getContext();
            sc.setAuthentication(auth);

            users = userGet.getUserByUserName(username1);
            if (users.getRole().equals(ADMIN_ROLE)) {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
                return "/login";
            }
            // Check is active account
            if (users.getIsActive()) {
                session.setAttribute("user", users);
                return "redirect:/";
            } else {
                request.setAttribute("error", "Tài khoản chưa được active. Hãy liên hệ với admin qua zalo hoặc số điện thoại để được active");
                return "/login";
            }

        } catch (UsernameNotFoundException e) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            return "/login";
        }

    }

    @PostMapping("/admin/login")
    public String loginAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        User users;
        HttpSession session = request.getSession();

        String username1 = request.getParameter("username");
        String password1 = request.getParameter("pass");

        try {
            UsernamePasswordAuthenticationToken authReq
                    = new UsernamePasswordAuthenticationToken(username1, password1);
            Authentication auth = authManager.authenticate(authReq);

            SecurityContext sc = SecurityContextHolder.getContext();
            sc.setAuthentication(auth);

            users = userGet.getUserByUserName(username1);

            if (users.getRole().equals(ADMIN_ROLE)) {
                session.setAttribute("useradmin", users);
                return "redirect:/admin";
            } else {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
                response.getWriter().write("<img src=\"img/available.png\" /> Tai khoan hop le");

                return "/admin/login";
            }

        } catch (UsernameNotFoundException e) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            response.getWriter().write("<img src=\"img/available.png\" /> Tai khoan hop le");

            return "/admin/login";
        }

    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            Object sessionuser = session.getAttribute("user");
            if (sessionuser != null) {
                session.removeAttribute("user");
                response.sendRedirect("/index");
            }

        } finally {
            out.close();
        }
        return null;
    }

    @PostMapping("/register")
    public String register(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        // Check username exist
        String userName = request.getParameter("name");
        boolean isUserExist = userGet.checkEmail(userName);

        if (isUserExist) {
            request.setAttribute("message", "Tên đăng nhập đã được sử dụng");
            return "/register";
        }

        // verify pass word confirm
        String pass = request.getParameter("pass");
        String confirmPass = request.getParameter("confirm_pass");

        if (!pass.equals(confirmPass)) {
            request.setAttribute("message", "Mật khẩu không trùng khớp");
            return "/register";
        }

        User users = new User();

        users.setUserID(new java.util.Date().getTime());
        users.setUserName(request.getParameter("name"));
        users.setPassword(encoder.encode(request.getParameter("pass")));
        users.setBirthday(request.getParameter("biirthday"));
        users.setZaloName(request.getParameter("zalo-name"));
        users.setZaloPhoneNumber(request.getParameter("zalo-phone"));
        users.setFullName(request.getParameter("full-name"));
        users.setPhoneNumber(request.getParameter("phone"));
        users.setAddress(request.getParameter("address"));
        users.setIsActive(false);
        users.setRole(USER_ROLE);

        userGet.insertUser(users);

        request.setAttribute("message", "Đăng ký thành công. Mời đăng nhập");
        return "login";
    }

    @PostMapping("/updateInfo")
    public String update(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        try {
            User user = new User();
            Long id = Long.parseLong(request.getParameter("id"));
            user.setUserID(id);
            user.setBirthday(request.getParameter(("biirthday")));
            user.setZaloName(request.getParameter(("zalo-name")));
            user.setZaloPhoneNumber(request.getParameter(("zalo-phone")));
            user.setFullName(request.getParameter(("full-name")));
            user.setPhoneNumber(request.getParameter(("phone")));
            user.setAddress(request.getParameter(("address")));

            userGet.updateUser(user);

            response.getWriter().write("success");
        } catch (IOException ex) {
            Logger.getLogger("account.update").log(Level.SEVERE, "Update account information false !!", ex);
        }
        return null;
    }

    @PostMapping("/updatePassword")
    public String updatePassword(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        try {
            User user = new User();
            user.setUserID(Long.parseLong(request.getParameter("id")));
            String newPass = request.getParameter("new_pass");
            user.setPassword(encoder.encode(newPass));

            userGet.updatePassword(user);

            response.getWriter().write("success");
        } catch (IOException ex) {
            Logger.getLogger("account.update").log(Level.SEVERE, "Update account information false !!", ex);
        }
        return null;
    }

    @PostMapping("/resetPassword")
    public String resetPassword(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        try {
            User user = new User();
            user.setUserID(Long.parseLong(request.getParameter("id")));
            String newPass = PASSWORD_DEFAULT;
            user.setPassword(encoder.encode(newPass));

            userGet.updatePassword(user);

            response.getWriter().write("success");
        } catch (IOException ex) {
            Logger.getLogger("account.update").log(Level.SEVERE, "Update account information false !!", ex);
        }
        return null;
    }

    @PostMapping("/activeAccount")
    public String activeAccount(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        try {
            User user = new User();
            user.setUserID(Long.parseLong(request.getParameter("id")));
            user.setIsActive(request.getParameter("state").equals("Inactive"));

            userGet.activeAccount(user);

            if (user.getIsActive()) {
                response.getWriter().write("active");
            } else {
                response.getWriter().write("inactive");
            }
        } catch (IOException ex) {
            Logger.getLogger("account.update").log(Level.SEVERE, "Update account information false !!", ex);
        }
        return null;
    }

    @PostMapping("/checkPassword")
    public String checkPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String username1 = request.getParameter("username");
        String password1 = request.getParameter("pass");
        try {
            UsernamePasswordAuthenticationToken authReq
                    = new UsernamePasswordAuthenticationToken(username1, password1);
            Authentication auth = authManager.authenticate(authReq);

            response.getWriter().write("success");
        } catch (UsernameNotFoundException e) {
            request.setAttribute("error", "Mật khẩu không chính xác");
            response.getWriter().write("false");
        }
        return null;
    }

    @PostMapping("/CheckUserName")
    public String CheckUserName(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        try {
            if (userGet.checkEmail(request.getParameter("username"))) {
                response.getWriter().write("<img src=\"/img/not-available.png\" /><span style='color:red'> Tài khoản này đã có người sử dụng </span>");
            } else {
                response.getWriter().write("<img src=\"/img/available.png\" /><span style='color:green'> Tài khoản hợp lệ<span>");
            }
        } catch (SQLException | IOException ex) {
            Logger.getLogger("CheckUserName.class.getName()").log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
