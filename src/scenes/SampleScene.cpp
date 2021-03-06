#include "SampleScene.h"
#include "../GeometryFactory.h"

SampleScene::SampleScene() : BaseScene()
{
    m_texture = ImagePtr(new Image("resources/textures/brdfLUT.png"));
    m_quad = GeometryFactory::quad(glm::vec2(2.0f));
    m_shader = ShaderPtr(new Shader("shaders/sample.vs", "shaders/sample.fs"));
}

SampleScene::~SampleScene()
{
}

void SampleScene::OnKey(int key, int scancode, int action, int mode)
{

}

void SampleScene::OnRender(float t, float dt)
{
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    m_shader->use();

    m_texture->bind(0);
    m_shader->uniform("debugTexture", 0);

    m_quad->draw();
}
