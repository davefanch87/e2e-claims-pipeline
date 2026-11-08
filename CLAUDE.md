# E2E Claims Pipeline

End-to-end data engineering pipeline on synthetic healthcare claims data:
land, load, transform, orchestrate, and triage failures with an AI agent.
Personal learning project. No real PHI, ever.

## Architecture
Synthea CSVs -> MinIO (raw/ bucket) -> dlt -> Postgres -> dbt -> marts
Airflow orchestrates dlt and dbt. A Claude Code agent triages failures.

## Repo map
- ingest/        dlt pipelines (MinIO -> Postgres raw)
- dbt/           dbt project: staging/, intermediate/, marts/
- airflow/dags/  DAGs (Cosmos renders dbt)
- agent/         triage prompts, MCP config, failure callback
- chaos/         scripts that break the pipeline on purpose
- scripts/       Synthea generation and daily slicing

## Commands
- Python deps managed with uv
- make up / make down     start or stop containers
- make load               run dlt ingest
- make dbt                dbt build (run + test)
- make chaos SCENARIO=x   inject a failure

## Data conventions
- Schemas: raw (dlt-owned), staging, intermediate, marts
- Staging: stg_<source>__<table>, 1:1 with source, rename/cast/dedupe only
- Marts: dim_*, fct_*, mart_*
- snake_case everywhere; ids end in _id; dates end in _date

## Rules
- This repo is public: never commit secrets, real data, or employer-specific details
- Never write to raw except through dlt
- Never edit raw data to make a test pass; fix it in staging or report it
- Every new dbt model gets a yml entry with tests
- Run make dbt before calling a change done
- Ask before changing docker-compose.yml or deleting data

## Status
Phase 1: infra (Postgres + MinIO)

Some commands above (make load, make dbt, make chaos) don't exist yet; that's expected.
