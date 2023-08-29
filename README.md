# dbt-tap-dbt-artifacts
This dbt package contains models for Matatika's [tap-dbt-artifacts](https://github.com/Matatika/tap-dbt-artifacts).

The main focus of the package is to transform stream `tap-dbt-artifacts` data into usable analytics models.

This package along with the [Analyze Bundle](https://github.com/Matatika/analyze-dbt-artifacts) are designed intended to work together to provide instant insights on the [Matatika Platform](https://www.matatika.com).

| **model**              | **description** |
| ---------------------- | ------------------------------------------------------------- |
| [fact_test_results](models/base/fact_test_results.sql) | Results from dbt test invocations |
| [vw_test_results_grouped](models/base/vw_test_results_grouped.sql) | Results from all dbt test invocations grouped by test name |


## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

Include in your `packages.yml`
```yaml
packages:
  - git: https://github.com/Matatika/dbt-tap-dbt-artifacts.git
```

### One time setup (after creating a python virtual environment)

    ```
    pip install dbt
    dbt deps
    ```

### development

    ```
    dbt test
    ```

## Database Support
This package has been tested on Postgres and Snowflake.

## Cloud hosting and SaaS
Deploy on the Matatika Platform within minutes. [www.matatika.com](https://www.matatika.com)

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Resources:
- Have questions, feedback, or need help? Please email us at support@matatika.com
- Find all of Matatika's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/Matatika/)
- Learn how to orchestrate [dbt transformations with Matatika](https://www.matatika.com/docs/getting-started/)
- Learn more about Matatika [in our docs](https://www.matatika.com/docs/introduction)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)

---

Copyright &copy; 2023 Matatika
