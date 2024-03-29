# Reflex Shader 2
[![release](https://img.shields.io/github/v/release/reflex1124/Reflex-Shader-2.svg?&style=for-the-badge)](https://github.com/reflex1124/Reflex-Shader-2/releases/latest)
[![lisence](https://img.shields.io/badge/license-MIT-green.svg?logo=&style=for-the-badge)](https://opensource.org/licenses/mit-license.php)
[![unity version](https://img.shields.io/badge/Unity-2018.4.20.f1-blue.svg?logo=unity&style=for-the-badge)](https://unity3d.com/jp/unity/whats-new/2018.4.20)
[![VRChat](https://img.shields.io/badge/-VRChat-blue.svg?logo=&style=for-the-badge)](https://vrchat.com/)

![Header](Images/RS_Header.png)

This shader is made for VRChat.  
このシェーダーはVRChatにおいて利用されることを前提に開発されています。

Version 2.2.0

## Reflex Shader 2.2について
Reflex Shader 2.2はVRChat向けに開発されているアバター向けシェーダーです。  
特徴的な機能として以下のものがあります。
- オブジェクトからの影に対応
- 影色の自由な指定
- Matcapやリムライトなどのリッチな表現
- 色味や明るさはCubed's Unity Shaderに似ています
- 各機能にマスクを入れる場所を用意してあるので、一部のみ機能を有効化することができます。
- VRChatのSafety設定においてシェーダーが無効化されStandardになった場合もテクスチャが維持されます
- ScanlineやEmissive Scrollなどの発光系の機能が豊富なので、Sci-Fi系のアバターに適しています

## 導入方法
UnitypackageをUnityからインポートしてください。

## Shaders / シェーダー一覧
- Reflex Shader 2
  - Reflex Shader 2 (一般的な不透明のシェーダーです)
  - Reflex Shader 2 Cutout (透過部分を切り抜くシェーダーです)
  - Reflex Shader 2 Transparent (半透明のシェーダーです)
  - Stencil/Write (ステンシルで透過させる側のシェーダーです)
  - Stencil/Read (ステンシルで透過される側のシェーダーです) 
  - No Outline
    - Opaque (アウトラインなしの不透明シェーダーです)
    - Cutout (アウトラインなしのカットアウトシェーダーです)
    - Transparent (アウトラインなしの半透明シェーダーです)
    - Stencil/Write (アウトラインなしのステンシルで透過させる側のシェーダーです) 
    - Stencil/Read (アウトラインなしのステンシルで透過される側のシェーダーです) 

## Contact / 連絡先
Twitter : @reflex_1124  
VRChat : reflex1124
