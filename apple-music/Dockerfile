FROM node:11-slim
LABEL version="0.0.1" maintainer="Naveed Golafshani / Jonathan Crooke"
WORKDIR /app
RUN apt-get update; \
		apt-get install -y git; \
		git clone https://github.com/naveedgol/apple-music-web-player.git /app; \
		cd /app; \
		npm install --only=production
EXPOSE 4200
CMD [ "npm", "start" ]

