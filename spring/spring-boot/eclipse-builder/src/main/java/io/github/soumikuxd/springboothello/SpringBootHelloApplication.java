package io.github.soumikuxd.springboothello;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;

import java.lang.reflect.Array;
import java.util.Arrays;

@SpringBootApplication
public class SpringBootHelloApplication {
	private static final Logger logger = LoggerFactory.getLogger(SpringBootHelloApplication.class);
	public static void main(String[] args) {
		SpringApplication.run(SpringBootHelloApplication.class, args);
	}

	@Bean
	public CommandLineRunner commandLineRunner(ApplicationContext context) {
		return args -> {
			logger.info("Inspecting the beans provided by Spring Boot:");
			String[] beanNames = context.getBeanDefinitionNames();
			Arrays.sort(beanNames);
			for (String beanName: beanNames) {
				logger.info(beanName);
			}
		};
	}
}
