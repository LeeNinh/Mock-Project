package com.tainguyen.demo.configurations;

import com.tainguyen.demo.model.User;
import com.tainguyen.demo.repository.UserGet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Objects;

@Component
public class UserAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private UserGet userGet;

    @Autowired
    private PasswordEncoder encoder;

    @Override
    public Authentication authenticate(Authentication authentication)
            throws AuthenticationException {

        String name = authentication.getName();
        User user = userGet.getUserByUserName(name);
        if (Objects.nonNull(user)) {
            String password = authentication.getCredentials().toString();

            if (encoder.matches(password, user.getPassword())) {
                Collection<GrantedAuthority> authorities = new ArrayList<>();
                authorities.add(new SimpleGrantedAuthority(user.getRole()));
                return new UsernamePasswordAuthenticationToken(
                        name, password, authentication.getAuthorities());
            } else {
                throw new UsernameNotFoundException(name);
            }

        } else {
            throw new UsernameNotFoundException(name);
        }
    }


    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
