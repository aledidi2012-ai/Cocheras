# Andén 12 — Reservas de cocheras

App estática (HTML + JS, sin build) para reservar cocheras por hora, con Supabase como backend en tiempo real.

## 1. Supabase

1. Creá un proyecto en https://supabase.com (o usá uno existente).
2. Andá a **SQL Editor** → pegá el contenido de `supabase-schema.sql` → **Run**.
3. Andá a **Project Settings → API** y copiá:
   - `Project URL`
   - `anon public` key
4. Pegalos en `config.js`:
   ```js
   window.SUPABASE_URL = "https://xxxxx.supabase.co";
   window.SUPABASE_ANON_KEY = "eyJ...";
   ```

## 2. GitHub

```bash
cd cocheras-app
git init
git add .
git commit -m "Andén 12 - reservas de cocheras"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/cocheras.git
git push -u origin main
```

## 3. Vercel

1. En Vercel → **Add New → Project** → importá el repo de GitHub.
2. Es un sitio estático: no hace falta configurar build command ni output directory (dejalo vacío o "Other").
3. Deploy.

Listo — tu URL de Vercel ya sirve la app conectada a Supabase, con datos compartidos en tiempo real entre todos los que la abran.

## Personalizar

En `index.html`, al principio del `<script>`, está `SECTIONS`: ahí ajustás las secciones (autos, camionetas, motos), cuántas cocheras tiene cada una y la tarifa por hora.

```js
var SECTIONS = [
  { id:'A', name:'Sección A · Autos', type:'auto', rate:1500, count:10 },
  ...
];
```

## Seguridad — antes de usarla con clientes reales

El esquema SQL deja las políticas RLS abiertas (cualquiera con la `anon key` puede leer, crear y **cancelar** reservas) para que funcione de entrada sin login. Antes de ponerla en producción con pagos o datos reales, conviene:

- Agregar Supabase Auth para el panel del local, y restringir la política de `delete` (cancelar) a usuarios autenticados con rol de administrador.
- Si vas a cobrar de verdad, integrar un gateway de pago real (Mercado Pago tiene API) en vez del selector actual, que solo registra el medio de pago elegido sin procesar el cobro.
