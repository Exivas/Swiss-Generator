package com.example.swissgenerator

import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.os.Bundle
import android.view.View
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import java.util.*
import kotlin.math.cos
import kotlin.random.Random

// i use espaniglish, use translate for some string (It will be fixed in an update, be patient with me, I don't know much English)
class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

    }
    //clipboard copy
    fun copyText(view: View) {
        var txtTag: TextView = findViewById(R.id.txtGenerated)
        val clipboard = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
        val clip = ClipData.newPlainText("label", txtTag.text)
        clipboard.setPrimaryClip(clip)
        Toast.makeText(this, "Texto copiado al portapapeles", Toast.LENGTH_SHORT).show()

    }

//button generator
    fun generador(view: View) {
        var txtTag: TextView = findViewById(R.id.txtGenerated)
        var txtCustom: EditText = findViewById(R.id.EDT_name)
        var RBnormal: RadioButton = findViewById(R.id.RB_Normal)
        var RBcharacter: RadioButton = findViewById(R.id.RB_Signals)
        var RBcunstom: RadioButton = findViewById(R.id.RB_custom)

        var consonantes = "bcdfghjklmnpqrstvwxyz"
        var vocales = "aeiou"
        var consonanteVocales = true
        var generado = ""


        var limite = Random.nextInt(3, 11)
        // radiobutton checks
        if (RBcunstom.isChecked == true) {
            generado = customName(txtCustom.text.toString())


        } else {
            for (i in 1..limite) {

                if (RBnormal.isChecked == true) {
                    if (consonanteVocales == true) {
                        var index = Random.nextInt(consonantes.length)
                        generado += consonantes[index]
                        consonanteVocales = false

                    } else {
                        var index = Random.nextInt(vocales.length)
                        generado += vocales[index]
                        consonanteVocales = true
                    }

                }

                if (RBcharacter.isChecked == true) {
                    vocales += "éµ¡⌀₠₳€£ĀāǍǎĂăãÃââÂáÁÀàÄäÅåĄÆæĒēĚěĔĕėĖêÊéÉÈèËëĘęɜɘəɛɞɝŪūǓǔŬŭũŨûÛúÚÙùÜüűŰǛǖǕǜǙǚŲųʊ▴▵ÒòÖöɸøØŏŎÕõŒŐő"
                    consonantes += "$¥฿₩₫֏₦₡₺₪₹€₽₢₱৳₲₥₾₴₵₭₿₣⃀₯₠ℳ₰CĆĊċĎďɗÐðĉʤĜɠĞʩĠġĝğģĤHhĥɥɦʜĶķʞĸĽLĹĻļɭĿŁŃɱɰÑŅŊŋŇŉʬŴŷŶŸÿŹźýÝ"
                    if (consonanteVocales == true) {
                        var index = Random.nextInt(consonantes.length)
                        generado += consonantes[index]
                        consonanteVocales = false

                    } else {
                        var index = Random.nextInt(vocales.length)
                        generado += vocales[index]
                        consonanteVocales = true
                    }
                }

            }
        }
        //results to textview
        txtTag.text = generado.replaceFirstChar { if (it.isLowerCase()) it.titlecase(Locale.getDefault()) else it.toString() }
        print(generado)

    }


    fun customName(name: String): String {
        val palabras = name.split(" ")
        val resultado = mutableListOf<String>()
        for (palabra in palabras) {
            val letras = palabra.toCharArray()
            val consonantes = letras.filter { it !in "aeiouAEIOU" }.shuffled().toMutableList()
            val vocales = letras.filter { it in "aeiouAEIOU" }.shuffled().toMutableList()
            var nuevaPalabra = ""
            for (letra in letras) {
                if (letra in "aeiouAEIOU") {
                    nuevaPalabra += vocales.removeAt(0)
                } else {
                    nuevaPalabra += consonantes.removeAt(0)
                }
            }
            resultado.add(nuevaPalabra.lowercase(Locale.getDefault()))
        }
        return resultado.joinToString(" ")
    }

}