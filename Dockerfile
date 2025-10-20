FROM klakegg/hugo:0.119.0-ext-alpine

WORKDIR /src

# Copy project files into the image. We still mount the project in docker-compose for live edits.
COPY . /src

# Pre-fetch Hugo modules to speed up first run
RUN hugo mod get -u || true

EXPOSE 1313

CMD ["hugo", "server", "-D", "--bind", "0.0.0.0", "--port", "1313"]
