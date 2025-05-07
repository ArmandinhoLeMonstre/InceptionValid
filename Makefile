all:
	sudo mkdir -p /home/armitite/data/wordpress /home/armitite/data/mariadb
	sudo chmod -R 777 /home/armitite/data
	docker compose --project-directory ./srcs up --build -d

clean:
	docker compose --project-directory ./srcs down

fclean:
	docker compose --project-directory ./srcs down --volumes --rmi all
	sudo rm -rf /home/armitite/data/mariadb/*
	sudo rm -rf /home/armitite/data/wordpress/*
	docker image prune -f
	docker system prune -a


ps:
	docker compose --project-directory ./srcs ps


re: fclean all

.PHONY: all clean fclean re ps logs
