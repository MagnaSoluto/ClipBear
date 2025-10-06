# 📱 App Group Setup Instructions - ClipBear

## 🎯 O Que é App Group?

App Group permite compartilhar dados entre o app principal e a extensão do widget usando `UserDefaults` compartilhado.

**App Group ID**: `group.com.clipbear.mvp`

---

## ⚙️ Como Habilitar no Xcode

### **Passo 1: Habilitar para o App Principal**

1. Abra o projeto no Xcode
2. Selecione o projeto **ClipBear** no navegador
3. Selecione o target **ClipBear** (app principal)
4. Vá para a aba **Signing & Capabilities**
5. Clique no botão **"+ Capability"**
6. Procure e adicione **"App Groups"**
7. Marque ou adicione: **`group.com.clipbear.mvp`**
8. Salve (Cmd+S)

### **Passo 2: Habilitar para o Widget**

1. No mesmo projeto
2. Selecione o target **ClipBearWidget** (extensão)
3. Vá para **Signing & Capabilities**
4. Clique **"+ Capability"**
5. Adicione **"App Groups"**
6. Marque **`group.com.clipbear.mvp`** (mesmo ID)
7. Salve (Cmd+S)

---

## 📄 Entitlements File

Após habilitar, Xcode criará automaticamente os arquivos `.entitlements`:

### **ClipBear.entitlements**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.application-groups</key>
    <array>
        <string>group.com.clipbear.mvp</string>
    </array>
</dict>
</plist>
```

### **ClipBearWidget.entitlements**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.application-groups</key>
    <array>
        <string>group.com.clipbear.mvp</string>
    </array>
</dict>
</plist>
```

---

## ✅ Verificação

### **Como saber se está funcionando?**

1. **Console Logs**: Ao criar uma suggestion, deve aparecer:
   ```
   ✅ Published suggestion to widget: [mensagem]
   ```

2. **Widget Atualiza**: O widget na home screen deve mostrar a última suggestion

3. **Sem Erros**: Se não estiver habilitado, aparecerá:
   ```
   ⚠️ Failed to access App Group UserDefaults: group.com.clipbear.mvp
   ```

---

## 🧪 Como Testar

### **Teste 1: Publicar Suggestion**
```swift
// Em MainView ou DemoView, adicione:
WidgetService.shared.publishLatestSuggestionToWidget("Test suggestion from app!")
```

### **Teste 2: Verificar Widget**
1. Adicione o widget ClipBear na home screen
2. Execute o app
3. Crie uma demo suggestion
4. Verifique se o widget atualiza

### **Teste 3: Deep Link**
1. Adicione widget na home screen
2. Toque no widget
3. App deve abrir

---

## 🔧 Troubleshooting

### **Erro: "Failed to access App Group"**
**Solução**:
- Verifique se App Group está habilitado em **ambos** os targets
- Verifique se o ID é exatamente `group.com.clipbear.mvp`
- Limpe build folder (Cmd+Shift+K)
- Rebuild

### **Widget não atualiza**
**Solução**:
- Force quit o app
- Remova e adicione o widget novamente
- Verifique se `WidgetCenter.shared.reloadAllTimelines()` está sendo chamado

### **Deep link não funciona**
**Solução**:
- Adicione URL Scheme em Info.plist (veja abaixo)

---

## 🔗 URL Scheme Configuration

Para o deep link `clipbear://open` funcionar, adicione ao **Info.plist**:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>com.clipbear.mvp</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>clipbear</string>
        </array>
    </dict>
</array>
```

Ou no Xcode:
1. Target ClipBear > Info
2. Adicione em **URL Types**:
   - Identifier: `com.clipbear.mvp`
   - URL Schemes: `clipbear`

---

## 📊 Status Atual

- ✅ Widget code implementado
- ✅ WidgetService com publishLatestSuggestionToWidget()
- ✅ App Group ID definido: `group.com.clipbear.mvp`
- ✅ clearWidget() implementado
- ✅ Deep link URL: `clipbear://open`
- ✅ Accessibility labels adicionados
- ⚠️ **AÇÃO MANUAL NECESSÁRIA**: Habilitar App Group capability no Xcode

---

## 🚀 Próximos Passos

1. **Habilitar App Group** (manual no Xcode - 2 minutos)
2. **Adicionar URL Scheme** (manual no Xcode - 1 minuto)
3. **Testar widget** (adicionar na home screen)
4. **Verificar deep link funciona**

---

*Criado em: 2025-10-06*  
*Status: Widget Code 100% Ready - Requires Manual Xcode Setup*

