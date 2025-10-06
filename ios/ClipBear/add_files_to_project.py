#!/usr/bin/env python3
"""
Script para adicionar arquivos Swift ao projeto Xcode
"""

import os
import re
import uuid

def generate_uuid():
    """Gera um UUID no formato do Xcode"""
    return str(uuid.uuid4()).replace('-', '').upper()[:24]

def add_swift_files_to_project():
    """Adiciona todos os arquivos Swift ao projeto"""
    
    # Ler o arquivo de projeto
    with open('ClipBear.xcodeproj/project.pbxproj', 'r') as f:
        content = f.read()
    
    # Encontrar todos os arquivos Swift
    swift_files = []
    for root, dirs, files in os.walk('ClipBear'):
        for file in files:
            if file.endswith('.swift'):
                rel_path = os.path.join(root, file)
                swift_files.append(rel_path)
    
    print(f"Encontrados {len(swift_files)} arquivos Swift:")
    for f in swift_files:
        print(f"  - {f}")
    
    # Gerar UUIDs para os arquivos
    file_refs = {}
    build_files = {}
    
    for file_path in swift_files:
        file_id = generate_uuid()
        build_id = generate_uuid()
        
        file_refs[file_path] = file_id
        build_files[file_path] = build_id
    
    # Adicionar fileRefs
    file_refs_section = ""
    for file_path, file_id in file_refs.items():
        file_name = os.path.basename(file_path)
        file_refs_section += f"\t\t{file_id} /* {file_name} */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = {file_name}; sourceTree = \"<group>\"; }};\n"
    
    # Adicionar buildFiles
    build_files_section = ""
    for file_path, build_id in build_files.items():
        file_name = os.path.basename(file_path)
        file_id = file_refs[file_path]
        build_files_section += f"\t\t{build_id} /* {file_name} in Sources */ = {{isa = PBXBuildFile; fileRef = {file_id} /* {file_name} */; }};\n"
    
    # Adicionar ao grupo de arquivos
    group_section = ""
    for file_path, file_id in file_refs.items():
        file_name = os.path.basename(file_path)
        group_section += f"\t\t\t\t{file_id} /* {file_name} */,\n"
    
    # Adicionar às sources
    sources_section = ""
    for file_path, build_id in build_files.items():
        file_name = os.path.basename(file_path)
        sources_section += f"\t\t\t\t{build_id} /* {file_name} in Sources */,\n"
    
    # Substituir no conteúdo
    # Adicionar fileRefs
    content = re.sub(
        r'(/\* End PBXFileReference section \*/)',
        f'{file_refs_section}\t\t/* End PBXFileReference section */',
        content
    )
    
    # Adicionar buildFiles
    content = re.sub(
        r'(/\* End PBXBuildFile section \*/)',
        f'{build_files_section}\t\t/* End PBXBuildFile section */',
        content
    )
    
    # Adicionar ao grupo
    content = re.sub(
        r'(A1234567890ABCDEF1234568 /\* ContentView\.swift \*/,)',
        f'A1234567890ABCDEF1234568 /* ContentView.swift */,\n{group_section}',
        content
    )
    
    # Adicionar às sources
    content = re.sub(
        r'(A1234567890ABCDEF1234569 /\* ContentView\.swift in Sources \*/,)',
        f'A1234567890ABCDEF1234569 /* ContentView.swift in Sources */,\n{sources_section}',
        content
    )
    
    # Salvar o arquivo modificado
    with open('ClipBear.xcodeproj/project.pbxproj', 'w') as f:
        f.write(content)
    
    print("Arquivos adicionados ao projeto!")

if __name__ == "__main__":
    add_swift_files_to_project()






