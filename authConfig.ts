import {
  type Configuration,
  type RedirectRequest,
  PublicClientApplication,
} from "@azure/msal-browser";

const {
  VITE_ENTRA_CLIENT_ID,
  VITE_ENTRA_TENANT_ID,
  VITE_API_SCOPE,
} = window.__APP_CONFIG__ ?? import.meta.env;
const appUrl = new URL(import.meta.env.BASE_URL, window.location.origin).toString();

if (!VITE_ENTRA_CLIENT_ID || !VITE_ENTRA_TENANT_ID || !VITE_API_SCOPE) {
  throw new Error("Missing Entra ID configuration. See .env.example.");
}

// MSAL Browser uses the authorization code flow with PKCE for SPAs.
const msalConfig: Configuration = {
  auth: {
    clientId: VITE_ENTRA_CLIENT_ID,
    authority: `https://login.microsoftonline.com/${VITE_ENTRA_TENANT_ID}`,
    redirectUri: appUrl,
    postLogoutRedirectUri: appUrl,
  },
  cache: {
    cacheLocation: "sessionStorage",
  },
};

export const loginRequest: RedirectRequest = {
  scopes: [VITE_API_SCOPE],
};

export const msalInstance = new PublicClientApplication(msalConfig);
