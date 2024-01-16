# GitHub Actions Workflows README

This repository contains several GitHub Actions workflows designed to automate development, testing, and deployment processes in software projects.

## Included Workflows

### 1. Update Package Version Workflow (`update-version-workflow`)

This workflow is triggered on workflow calls to update package.json version.

#### Features:
- Update the package version by determining the increment type, [fix|hotfix|feature|feat|core] using fix as default
- Create a commit with `bump:app-package-version` to be ignored
- Requires Personal Access Token with all repo checks and workflow check.

### 2. Deployments Workflow (`deployments-workflow.yml`)

This workflow facilitates automated deployments to staging and production environments using Heroku.

#### Features:
- Deploys to a staging environment on every push.
- Deploys to a production environment when a release is published.
- Utilizes `akhileshns/heroku-deploy` GitHub Action for deployments.
- Requires Heroku API key, app names, and Heroku email as inputs or secrets.

### 3. Ephemeral Environment Workflow (`ephemeral-environment-workflow.yml`)

Designed to manage and deploy ephemeral environments for pull requests, this workflow is highly useful for testing and review purposes.

#### Features:
- Builds a Docker image as part of the environment setup.
- Manages ephemeral environments on Heroku, creating or destroying them based on the PR status.
- Deploys the application to the ephemeral environment.
- Comments on the PR with a link to the deployed ephemeral environment.
- Requires repository details, app name, Heroku credentials, and the PR number as inputs.

## Usage

To use these workflows in your project, you may need to make necessary adjustments to fit your specific project configuration, especially regarding secrets management, environment variables, and specific deployment settings.

### 1. Update Package Version Workflow (`update-version-workflow`)

add `.github/workflows/update-version.yml`

```yml
name: Update Package Version

on:
  push:
    branches:
      - main

jobs:
  update-version-workflow:
    uses: imenesesl/heroku-workflow/.github/workflows/update-version-workflow.yml@main
    secrets:
      GITHUB_REPO_PAT: ${{ secrets.REPO_ACCESS }}
    with:
      package_json_path: "./package.json"
```

### 2. Deployments Workflow (`deployments-workflow.yml`)

add `.github/workflows/deployments.yml`

```yml
name: Deployments

on:
  push:
    branches:
      - main
  release:
    types: [published]

jobs:
  deployments-workflow:
    uses: imenesesl/heroku-workflow/.github/workflows/deployments-workflow.yml@main
    secrets:
      HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
    with:
      prod_app_name: react-vite
      stg_app_name: stg-react-vite
      heroku_email: "luismenesesep@gmail.com"
```

### 3. Ephemeral Environment Workflow (`ephemeral-environment-workflow.yml`)

add `.github/workflows/ephemeral-environment.yml`

```yml
name: Ephemeral Environment

on:
  pull_request:
    types: [opened, reopened, synchronize, closed]

permissions:
  pull-requests: write

jobs:
  ephemeral-environment-workflow:
    uses: imenesesl/heroku-workflow/.github/workflows/ephemeral-environment-workflow.yml@main
    secrets:
      HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
      GITHUB_SECRET_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    with:
      repository_owner: ${{ github.repository_owner }}
      repository_name: ${{ github.event.repository.name }}
      app_name: react-vite-pr-${{ github.event.number }}
      heroku_email: "luismenesesep@gmail.com"
      pr_number: ${{ github.event.number }}
```

## Obtaining and Storing Heroku API Key for GitHub Actions

### Prerequisites
- A Heroku account (Note: Heroku requires a credit card for verifying accounts, even for free-tier usage. This is to validate your identity and to prevent abuse.)

### Steps to Obtain HEROKU_API_KEY
1. **Log in to Heroku**:
   - Visit [Heroku](https://www.heroku.com/) and log in to your account.

2. **Access Account Settings**:
   - Click on your avatar in the upper right corner of the dashboard.
   - Select `Account settings` from the dropdown menu.

3. **Find API Key Section**:
   - Scroll down to the `API Key` section on the Account settings page.

4. **Reveal and Copy API Key**:
   - Click the `Reveal` button to display your API key.
   - Copy this API key; you'll need it for the next steps.

### Steps to Store HEROKU_API_KEY in GitHub
1. **Open Your GitHub Repository**:
   - Navigate to the GitHub repository where you intend to use the Heroku API key.

2. **Go to Repository Settings**:
   - Click on `Settings` in the top menu of your repository.

3. **Access Secrets Section**:
   - On the left sidebar, click on `Secrets` under the `Security` group.

4. **Add New Repository Secret**:
   - Click the `New repository secret` button.
   - In the `Name` field, enter `HEROKU_API_KEY`.
   - In the `Value` field, paste the Heroku API key you copied earlier.

5. **Save the Secret**:
   - Click the `Add secret` button to save it.

## Obtaining and Storing Personal Access Token (PAT) for GitHub Actions

### Prerequisites

### Steps to Create a Personal Access Token (PAT)

1. **Go to Your GitHub Settings**: Log in to your GitHub account. Click on your profile picture in the top right corner and select "Settings".

2. **Access Developer Settings**: Scroll down to the bottom of the sidebar and click on "Developer settings".

3. **Generate New Token**: In the "Developer settings" page, select "Personal access tokens", then click the "Generate new token" button.

4. **Set Token Description**: Enter a description for the token in the "Note" field. For example, "CI/CD Access".

5. **Select Scopes**: 
   - Check the `repo` scope box to grant full control of private repositories. This scope includes access to code, commit statuses, repository projects, invitations, and more.
   - Check the `workflow` scope to allow the token to run workflows.

6. **Generate Token**: Click the "Generate token" button at the bottom of the page.

7. **Copy the Token**: **Important!** Make sure to copy the token now. You won’t be able to see it again once you navigate away from the page.

### Steps to Save the PAT as a Secret in Your Repository

1. **Go to Your Repository**: Navigate to the GitHub repository where you want to add the PAT as a secret.

2. **Open Repository Settings**: Click on the "Settings" tab near the top of the page.

3. **Access Secrets**: In the repository settings, find and click on "Secrets" in the left sidebar.

4. **Add a New Secret**: Click on the "New repository secret" button.

5. **Name the Secret**: Enter a name for your secret in the "Name" field, such as `GITHUB_REPO_PAT`.

6. **Paste Your Token**: In the "Value" field, paste the PAT you copied earlier.

7. **Add Secret**: Click the "Add secret" button to save the PAT as a secret in your repository.

### Using the PAT in GitHub Actions

- In your GitHub Actions workflow file, you can now reference this secret with `${{ secrets.GITHUB_REPO_PAT }}`.
- This allows your workflow to perform actions that require GitHub authentication, like pushing to protected branches.

Now,

your GitHub Actions workflow can securely access the `HEROKU_API_KEY` secret to interact with Heroku for deployments or other operations.

### Important Notes
- **Security**: Treat your Heroku API key as sensitive information. Do not share it publicly or include it in your codebase.
- **Usage in Workflow**: In your GitHub Actions workflow file, you can reference this secret as `${{ secrets.HEROKU_API_KEY }}`.
- **Credit Card Requirement**: While Heroku offers a free tier, they require a credit card for account verification. This helps prevent fraudulent use of their services

and is a standard practice for many cloud service providers. Ensure that your Heroku account is verified with a credit card to avoid any interruptions in service.

## Examples

### [react-vite-heroku-workflow](https://github.com/imenesesl/react-vite-heroku-workflow)
