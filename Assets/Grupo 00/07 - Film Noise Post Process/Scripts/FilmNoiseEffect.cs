using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Camera))]
public class FilmNoiseEffect : MonoBehaviour
{
    [SerializeField] private Material filmNoiseMaterial;
    [SerializeField] private Slider noiseSlider;

    private void Start()
    {
        if (noiseSlider != null)
            noiseSlider.onValueChanged.AddListener(val => filmNoiseMaterial.SetFloat("_NoiseIntensity", val));
    }

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (filmNoiseMaterial != null)
            Graphics.Blit(src, dest, filmNoiseMaterial);
        else
            Graphics.Blit(src, dest);
    }
}
