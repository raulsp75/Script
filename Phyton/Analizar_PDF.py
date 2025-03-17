# pdf_to_jpg_converter.py
import os
import re
import sys
import zipfile
from datetime import datetime
from pathlib import Path
import fitz  # PyMuPDF
from PIL import Image

# Configuración
DPI = 300
MAX_NOMBRE = 40
PREFIJO = "hor"
CARPETA_SALIDA = "resultados_pdf"

def limpiar_nombre(texto):
    """Normaliza nombres para archivos"""
    texto = re.sub(r'\s+', ' ', texto).strip()
    texto = re.sub(r'[^\w\sáéíóúñÁÉÍÓÚÑ-]', '', texto, flags=re.UNICODE)
    return re.sub(r'\s', '_', texto[:MAX_NOMBRE])

def extraer_especialidad(texto_pagina):
    """Extrae la especialidad usando múltiples patrones"""
    patrones = [
        r'(?:ESPECIALIDAD|ÁREA|ASIGNATURA)[:\s-]*([^\n]+)',
        r'Tema:\s*([^\n]+)',
        r'Nombre del curso:\s*([^\n]+)'
    ]
    for patron in patrones:
        match = re.search(patron, texto_pagina, re.IGNORECASE)
        if match:
            return limpiar_nombre(match.group(1))
    return None

def procesar_pdf(ruta_pdf):
    """Convierte PDF a imágenes usando PyMuPDF"""
    doc = fitz.open(ruta_pdf)
    total_paginas = len(doc)
    nombre_base = Path(ruta_pdf).stem
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    
    carpeta_destino = Path(CARPETA_SALIDA) / f"{nombre_base}_{timestamp}"
    carpeta_destino.mkdir(parents=True, exist_ok=True)
    
    print(f"\nProcesando: {Path(ruta_pdf).name}")
    print(f"Páginas totales: {total_paginas}")
    print(f"Directorio de salida: {carpeta_destino}\n")

    for i in range(total_paginas):
        try:
            pagina = doc.load_page(i)
            texto = pagina.get_text()
            especialidad = extraer_especialidad(texto)
            
            # Renderizar página como imagen
            pix = pagina.get_pixmap(dpi=DPI)
            img = Image.frombytes("RGB", [pix.width, pix.height], pix.samples)
            
            # Generar nombre del archivo
            nombre_archivo = (
                f"{PREFIJO}-{especialidad}_p{i+1}.jpg" 
                if especialidad 
                else f"pagina_{i+1}.jpg"
            )
            
            # Guardar imagen
            ruta_guardado = carpeta_destino / nombre_archivo
            img.save(ruta_guardado, "JPEG", quality=95)
            
            print(f"Página {i+1:03d}: {nombre_archivo}")

        except Exception as e:
            print(f"Error en página {i+1}: {str(e)}")
            continue

    doc.close()
    return carpeta_destino

def comprimir_resultados(carpeta):
    """Crea archivo ZIP con los resultados"""
    zip_path = carpeta.with_name(f"{carpeta.name}.zip")
    
    with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for archivo in carpeta.glob('*.jpg'):
            zipf.write(archivo, archivo.name)
    
    # Limpieza
    for archivo in carpeta.glob('*.jpg'):
        archivo.unlink()
    carpeta.rmdir()
    
    print(f"\nArchivo ZIP creado: {zip_path}")
    return zip_path

def main():
    ruta_pdf = input("Introduce la ruta completa del archivo PDF: ").strip()
    
    if not Path(ruta_pdf).exists():
        print("\nError: El archivo no existe")
        return
    
    if not ruta_pdf.lower().endswith('.pdf'):
        print("\nError: El archivo debe ser un PDF")
        return
    
    try:
        carpeta = procesar_pdf(ruta_pdf)
        zip_path = comprimir_resultados(carpeta)
        print("\nProceso completado exitosamente!")
        print(f"Archivo resultante: {zip_path}")
    except Exception as e:
        print(f"\nError durante el procesamiento: {str(e)}")

if __name__ == "__main__":
    main()
