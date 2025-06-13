using UnityEngine;
using UnityEngine.UI;

public class MetallicShaderController : MonoBehaviour
{
    [SerializeField] private Material metallicMaterial;
    [SerializeField] private Slider speedSlider;
    [SerializeField] private Slider angleSlider;
    [SerializeField] private Slider sharpnessSlider;

    private void Start()
    {
        if (metallicMaterial != null)
        {
            speedSlider?.onValueChanged.AddListener(val => metallicMaterial.SetFloat("_Speed", val));
            angleSlider?.onValueChanged.AddListener(val => metallicMaterial.SetFloat("_Angle", val));
            sharpnessSlider?.onValueChanged.AddListener(val => metallicMaterial.SetFloat("_Sharpness", val));
        }
    }
}
