# Deploy Home Account Dashboard

This project is a static HTML dashboard and can be deployed easily to GitHub Pages, Netlify, or Vercel.

## Files
- `index.html` — main dashboard page
- `home-account-data.json` — optional data file
- `export-home-account.ps1` / `read-home-account.ps1` — PowerShell utilities

## GitHub Pages
1. Create a GitHub repository and push this folder as the repository root.
2. Ensure `index.html` is in the repository root.
3. In repository Settings > Pages, set the source branch to `main` or `master` and folder to `/ (root)`.
4. Save. Your site is published at `https://<username>.github.io/<repo-name>/`.

## Netlify
1. Create an account at https://netlify.com.
2. Add a new site from Git.
3. Connect your repository.
4. Set build command to `none` and publish directory to `/`.
5. Deploy.

## Vercel
1. Create an account at https://vercel.com.
2. Import project from Git.
3. Set framework preset to `Other` or `Static Site`.
4. Set output directory to `/`.
5. Deploy.

## Notes
- No build step is required.
- If you want a custom domain, configure it in the hosting provider.
- The site will work as a static HTML page with Chart.js loaded from CDN.

## Cloud Sync (Cross-Machine) with Firebase Realtime Database
To enable automatic sync across devices, add your Firebase Web config before `</head>` in `index.html`:

```html
<script>
  window.HOME_ACCOUNT_FIREBASE_CONFIG = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_PROJECT.firebaseapp.com",
    databaseURL: "https://YOUR_PROJECT-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "YOUR_PROJECT",
    storageBucket: "YOUR_PROJECT.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID"
  };
</script>
```

Then:
1. Create a Firebase project.
2. Enable Realtime Database.
3. Enable **Anonymous Authentication** in Firebase Authentication > Sign-in method.
4. In Realtime Database > Rules, apply rules from `database.rules.json`.
5. Deploy `index.html` as usual.

When configured, the UI shows Cloud Sync status and updates data automatically between machines.
