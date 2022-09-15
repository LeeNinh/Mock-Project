package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.CkEditorImage;
import com.tainguyen.demo.model.ImageUrl;
import com.tainguyen.demo.repository.ImageRepo;
import com.tainguyen.demo.repository.UtilityRepo;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import static com.tainguyen.demo.controllers.utilities.Utility.*;

@Controller
public class ImageController {
    @Autowired
    UtilityRepo utilityRepo;

    @Autowired
    ImageRepo imageRepo;

    @GetMapping(value = "/image")
    public @ResponseBody
    byte[] getImage(@RequestParam String fileName) throws IOException {
        File initialFile = new File(utilityRepo.getUtilityByKey(UPLOAD_DIRECTORY) + fileName);
        InputStream targetStream = new FileInputStream(initialFile);

        return IOUtils.toByteArray(targetStream);
    }

    @PostMapping(value = "/upload_image")
    public String uploadImage(HttpServletRequest request) throws IOException, ServletException, SQLException {
        String directory = utilityRepo.getUtilityByKey(UPLOAD_DIRECTORY);

        List filename = new ArrayList();

        // Upload image
        for (Part part : request.getParts()) {
            String fileName = extractFileName(part);
            // refines the fileName in case it is an absolute path
            fileName = new File(fileName).getName();
            if (fileName.equals("")) {
                continue;
            } else {
                // If image exist in db => ignore
                if (!imageRepo.getAllImageUrlByName(fileName)) {
                    filename.add(fileName);
                    part.write(directory + fileName);
                }
            }
        }

        // save image url to database
        for (int i = 0; i < filename.size(); i++) {
            ImageUrl imageUrl = new ImageUrl();
            imageUrl.setImageName(filename.get(i).toString());
            imageUrl.setImageUrl(URL_GET_IMAGE + filename.get(i).toString());

            imageRepo.insertImageUrl(imageUrl);
        }

        request.setAttribute("message", "Upload File Success!");

        return "/admin/upload_image";
    }

    /**
     * Extracts file name from HTTP header content-disposition
     */
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    @GetMapping(
            value = "/default-thumbnail",
            produces = MediaType.IMAGE_JPEG_VALUE)
    public @ResponseBody byte[] getThumbnailDefault() throws IOException {
        ClassLoader cl = this.getClass().getClassLoader();

        InputStream inputStream = cl.getResourceAsStream("static/images/thumbnail-default.jpg");
        if (inputStream == null) {
            throw new IllegalArgumentException("file not found!");
        } else {
            return IOUtils.toByteArray(inputStream);
        }
    }

    @PostMapping(value = "/ckeditor/upload")
    public @ResponseBody ResponseEntity<CkEditorImage> uploadImageCkEditor(@RequestParam("upload") MultipartFile file,
                                       HttpServletRequest request) {
        Path directory = Paths.get(utilityRepo.getUtilityByKey(CKEDITOR_UPLOAD));
        try {
            String extension = FilenameUtils.getExtension(file.getOriginalFilename());
            String fileName = "New_upload_" + UUID.randomUUID() + "." + extension;
            Files.copy(file.getInputStream(), directory.resolve(fileName));

            CkEditorImage ckEditorImage = new CkEditorImage( fileName);
            return ResponseEntity.ok().body(ckEditorImage);
        } catch (Exception e) {
            throw new RuntimeException("Could not store the file. Error: " + e.getMessage());
        }
    }

    @GetMapping(
            value = "/ckeditor/view/{fileName}",
            produces = MediaType.IMAGE_JPEG_VALUE)
    public @ResponseBody byte[] getCkEditorImageByName(@PathVariable String fileName) throws IOException {
        Path directory = Paths.get(utilityRepo.getUtilityByKey(CKEDITOR_UPLOAD));
            InputStream inputStream = new FileInputStream(new File(directory.toString() + "/" + fileName));
            if (inputStream == null) {
                throw new IllegalArgumentException("file not found!");
            } else {
                return IOUtils.toByteArray(inputStream);
            }
    }
}
