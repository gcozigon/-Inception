all:
	@if [ ! -f srcs/.env ]; then \
	    echo ".env file not found, here is an example of what it should contain:"; \
	    exit 1; \
	fi
	@if [ ! -d /home/${USER}/data/mariadb ]; then \
	    echo "Error: /home/${USER}/data/mariadb directory not found"; \
	    exit 1; \
	fi
	@if [ ! -d /home/${USER}/data/wordpress ]; then \
	    echo "Error: /home/${USER}/data/wordpress directory not found"; \
	    exit 1; \
	fi
	cd srcs; docker-compose up

clean:
	cd srcs; docker-compose down

fclean: clean
	docker system prune --all --force
	sudo rm -rf /home/${USER}/data/mariadb/*
	sudo rm -rf /home/${USER}/data/wordpress/*

re: fclean all

.PHONY: all clean fclean re
