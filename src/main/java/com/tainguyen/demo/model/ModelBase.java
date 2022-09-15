package com.tainguyen.demo.model;

import lombok.Data;

import java.time.Instant;

@Data
public abstract class ModelBase {

	private Instant createAt = Instant.now();

	private Instant modifyAt = Instant.now();
}
