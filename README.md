# Vestibulize 📚
 
> Plataforma web para gestão de estudos vestibulares — organização de cronogramas, conteúdos, rotinas e comunidade colaborativa entre estudantes.
 
![Java](https://img.shields.io/badge/Java-17-orange?style=flat-square&logo=openjdk)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.9-brightgreen?style=flat-square&logo=springboot)
![React](https://img.shields.io/badge/React-19.1.1-61DAFB?style=flat-square&logo=react)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker)
![AWS S3](https://img.shields.io/badge/AWS-S3-FF9900?style=flat-square&logo=amazons3)
 
---
 
## 📖 Sobre o projeto
 
O vestibular exige organização e disciplina durante um longo período de preparação. A falta de planejamento, dificuldade em gerenciar cronogramas e a ausência de um ambiente colaborativo impactam diretamente a performance dos estudantes.
 
O **Vestibulize** é uma plataforma web que centraliza tudo que o vestibulando precisa:
 
- 📅 Cronogramas e rotinas de estudo personalizados
- 📝 Gestão de conteúdos didáticos e anotações
- 🤖 Resumos automáticos gerados por IA (OpenAI GPT-4o-mini)
- 💬 Fórum colaborativo entre estudantes
- 📧 Notificações por e-mail via SendGrid
- ☁️ Armazenamento de arquivos no AWS S3
---
 
## 🗂️ Repositórios
 
| Repositório | Descrição | Linguagem |
|---|---|---|
| [FatecVestibulize/back-api](https://github.com/FatecVestibulize/back-api) | API REST com Spring Boot 3 + Java 17 | Java |
| [FatecVestibulize/front-web](https://github.com/FatecVestibulize/front-web) | Interface web com React 19 + Vite | JavaScript |
| [FatecVestibulize/docker-compose](https://github.com/FatecVestibulize/docker-compose) | Orquestração dos containers (este repositório) | Shell |
 
---
 
## 🏗️ Arquitetura
 
```
┌─────────────────────────────────────────────────────────┐
│                        Usuário                          │
└────────────────────────┬────────────────────────────────┘
                         │
          ┌──────────────▼──────────────┐
          │     Front-end (React/Vite)   │
          │         Porta 80 (Nginx)     │
          └──────────────┬──────────────┘
                         │ HTTP (REST)
          ┌──────────────▼──────────────┐
          │      API (Spring Boot)       │
          │         Porta 8080           │
          └──────┬───────────────┬───────┘
                 │               │
    ┌────────────▼───┐   ┌───────▼────────────┐
    │  MySQL 8.0     │   │  Integrações        │
    │  Porta 3306    │   │  · AWS S3           │
    └────────────────┘   │  · OpenAI API       │
                         │  · SendGrid         │
                         └────────────────────┘
```
 
---
 
## 🐳 Como executar localmente
 
**Pré-requisitos:** Docker e Docker Compose instalados.
 
```bash
# 1. Clone este repositório
git clone https://github.com/FatecVestibulize/docker-compose.git
cd docker-compose
 
# 2. Configure as variáveis de ambiente
cp .env.example .env
# Edite o .env com suas credenciais
 
# 3. Suba os containers
docker compose up -d
 
# 4. Acesse a aplicação
# Front-end: http://localhost
# API:       http://localhost:8080
```
 
---
 
## ⚙️ Variáveis de ambiente
 
Crie um arquivo `.env` na raiz com base no `.env.example`:
 
```env
# Banco de dados
DB_HOST=db
DB_PORT=3306
DB_NAME=vestibulize
DB_USER=seu_usuario
DB_PASSWORD=sua_senha
 
# JWT
JWT_SECRET=seu_secret_jwt
 
# AWS S3
AWS_ACCESS_KEY=sua_access_key
AWS_SECRET_KEY=sua_secret_key
AWS_BUCKET=seu_bucket
AWS_REGION=sua_regiao
 
# OpenAI
OPENAI_API_KEY=sua_api_key
 
# SendGrid
SENDGRID_API_KEY=sua_api_key
SENDGRID_FROM_EMAIL=seu_email
```
 
---
 
## 🛠️ Stack completa
 
| Camada | Tecnologias |
|---|---|
| Back-end | Java 17, Spring Boot 3.4.9, Spring Security, Spring Data JPA, JJWT, WebFlux |
| Front-end | React 19.1.1, Vite, PrimeReact, JavaScript ES6+ |
| Banco de dados | MySQL 8.0 |
| Infraestrutura | Docker, Docker Compose, Nginx Alpine, Amazon Corretto 17 |
| Integrações | AWS S3, OpenAI GPT-4o-mini, SendGrid |
| Segurança | JWT (HS256), BCrypt, variáveis de ambiente via `.env` |
 
---
 
## 🎓 Contexto acadêmico
 
Projeto desenvolvido como **Trabalho de Conclusão de Curso (TCC)** na **Fatec Ipiranga Pastor Eneas Tognini** — curso de Análise e Desenvolvimento de Sistemas.
