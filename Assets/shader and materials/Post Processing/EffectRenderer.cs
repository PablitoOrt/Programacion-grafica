using UnityEngine;

public class EffectRenderer : MonoBehaviour
{
    public Material currentEffectMaterial;  // Este se actualiza desde otro script

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (currentEffectMaterial != null)
            Graphics.Blit(src, dest, currentEffectMaterial);
        else
            Graphics.Blit(src, dest); // sin efecto
    }
}
