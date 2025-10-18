# Étape 1 : Builder l'application
FROM eclipse-temurin:25-jdk AS builder

# Définir le répertoire de travail
WORKDIR /app

# Copier le code source
COPY . .

# Compiler le projet (en mode production)
RUN ./mvnw clean package -DskipTests

# Étape 2 : Créer l'image finale (plus légère)
FROM eclipse-temurin:25-jre

WORKDIR /app

# Copier le jar compilé depuis l'étape précédente
COPY --from=builder /app/target/*.jar app.jar

# Exposer le port 8080
EXPOSE 8080

# Lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
