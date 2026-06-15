import { c as s, u as l, j as e, L as n } from "./index-BxvqvPvK.js";
const c = ["SP", "RJ", "MG", "RS", "PR", "BA", "CE", "PE", "GO", "DF"];
function f() {
  const i = s.useLoaderData(),
    o = s.useSearch(),
    r = l({ from: "/agencias" }),
    a = (t) => {
      r({ search: (d) => ({ ...d, ...t, page: 1 }) });
    };
  return e.jsxs("div", {
    style: { maxWidth: 1100, margin: "0 auto", padding: "32px 1rem" },
    children: [
      e.jsxs("div", {
        style: { marginBottom: 32 },
        children: [
          e.jsx("h1", {
            style: {
              fontSize: "2rem",
              fontWeight: 700,
              color: "#111827",
              marginBottom: 8,
            },
            children: "Agências de Elenco",
          }),
          e.jsxs("p", {
            style: { color: "#6b7280" },
            children: [
              i.total.toLocaleString("pt-BR"),
              " agências cadastradas",
            ],
          }),
        ],
      }),
      e.jsxs("div", {
        style: {
          background: "#fff",
          border: "1px solid #e5e7eb",
          borderRadius: 12,
          padding: "16px 20px",
          marginBottom: 24,
          display: "flex",
          flexWrap: "wrap",
          gap: 12,
        },
        children: [
          e.jsx("input", {
            type: "text",
            placeholder: "Buscar por nome da agência...",
            defaultValue: o.search || "",
            onKeyDown: (t) => {
              t.key === "Enter" && a({ search: t.target.value || void 0 });
            },
            style: {
              flex: 1,
              minWidth: 200,
              padding: "8px 14px",
              border: "1px solid #d1d5db",
              borderRadius: 8,
              fontSize: 14,
            },
          }),
          e.jsxs("select", {
            value: o.state || "",
            onChange: (t) => a({ state: t.target.value || void 0 }),
            style: {
              padding: "8px 14px",
              border: "1px solid #d1d5db",
              borderRadius: 8,
              fontSize: 14,
              background: "#fff",
            },
            children: [
              e.jsx("option", { value: "", children: "Todos os estados" }),
              c.map((t) => e.jsx("option", { value: t, children: t }, t)),
            ],
          }),
        ],
      }),
      i.agencies.length === 0
        ? e.jsxs("div", {
            style: { textAlign: "center", padding: "64px 0", color: "#9ca3af" },
            children: [
              e.jsx("div", {
                style: { fontSize: 48, marginBottom: 16 },
                children: "🏢",
              }),
              e.jsx("h3", {
                style: {
                  fontSize: 18,
                  fontWeight: 600,
                  color: "#374151",
                  marginBottom: 8,
                },
                children: "Nenhuma agência encontrada",
              }),
            ],
          })
        : e.jsx("div", {
            style: {
              display: "grid",
              gridTemplateColumns: "repeat(auto-fill, minmax(300px, 1fr))",
              gap: 20,
            },
            children: i.agencies.map((t) => e.jsx(p, { agency: t }, t.id)),
          }),
      e.jsxs("div", {
        style: {
          background: "#f0f9ff",
          border: "1px solid #bae6fd",
          borderRadius: 12,
          padding: "24px",
          textAlign: "center",
          marginTop: 48,
        },
        children: [
          e.jsx("p", {
            style: { color: "#374151", marginBottom: 12, fontWeight: 500 },
            children: "É uma agência e quer cadastrar seu elenco?",
          }),
          e.jsx(n, {
            to: "/cadastro",
            style: {
              display: "inline-block",
              padding: "10px 24px",
              background: "#0284c7",
              color: "#fff",
              borderRadius: 8,
              textDecoration: "none",
              fontWeight: 500,
              fontSize: 14,
            },
            children: "Cadastrar Agência",
          }),
        ],
      }),
    ],
  });
}
function p({ agency: i }) {
  const o = i.name.slice(0, 2).toUpperCase(),
    r =
      i.specialties
        ?.split(",")
        .map((a) => a.trim())
        .filter(Boolean) || [];
  return e.jsx(n, {
    to: "/agencias/$id",
    params: { id: String(i.id) },
    style: { textDecoration: "none", color: "inherit" },
    children: e.jsxs("div", {
      className: "talent-card",
      style: {
        background: "#fff",
        border: "1px solid #e5e7eb",
        borderRadius: 12,
        padding: "20px",
        cursor: "pointer",
      },
      children: [
        e.jsxs("div", {
          style: {
            display: "flex",
            gap: 14,
            marginBottom: 12,
            alignItems: "flex-start",
          },
          children: [
            e.jsx("div", {
              className: "avatar-placeholder",
              style: {
                width: 56,
                height: 56,
                borderRadius: 10,
                flexShrink: 0,
                fontSize: 18,
              },
              children: i.logoUrl
                ? e.jsx("img", {
                    src: i.logoUrl,
                    alt: i.name,
                    style: {
                      width: "100%",
                      height: "100%",
                      objectFit: "cover",
                    },
                  })
                : o,
            }),
            e.jsxs("div", {
              children: [
                e.jsx("div", {
                  style: {
                    fontWeight: 700,
                    fontSize: 16,
                    color: "#111827",
                    marginBottom: 2,
                  },
                  children: i.name,
                }),
                i.isAccredited &&
                  e.jsx("span", {
                    style: {
                      fontSize: 11,
                      background: "#d1fae5",
                      color: "#065f46",
                      padding: "2px 8px",
                      borderRadius: 100,
                      fontWeight: 600,
                    },
                    children: "✓ Credenciada",
                  }),
              ],
            }),
          ],
        }),
        i.description &&
          e.jsx("p", {
            style: {
              fontSize: 13,
              color: "#6b7280",
              lineHeight: 1.5,
              marginBottom: 12,
              display: "-webkit-box",
              WebkitLineClamp: 2,
              WebkitBoxOrient: "vertical",
              overflow: "hidden",
            },
            children: i.description,
          }),
        e.jsxs("div", {
          style: {
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
            fontSize: 12,
            color: "#9ca3af",
          },
          children: [
            e.jsxs("span", {
              children: [
                "📍 ",
                [i.city, i.state].filter(Boolean).join(", ") || "Brasil",
              ],
            }),
            i.talentCount
              ? e.jsxs("span", { children: [i.talentCount, " talentos"] })
              : null,
          ],
        }),
        r.length > 0 &&
          e.jsx("div", {
            style: { display: "flex", gap: 4, flexWrap: "wrap", marginTop: 10 },
            children: r
              .slice(0, 3)
              .map((a) =>
                e.jsx(
                  "span",
                  {
                    style: {
                      fontSize: 11,
                      background: "#f3f4f6",
                      color: "#6b7280",
                      padding: "2px 8px",
                      borderRadius: 100,
                    },
                    children: a,
                  },
                  a,
                ),
              ),
          }),
      ],
    }),
  });
}
export { f as component };
