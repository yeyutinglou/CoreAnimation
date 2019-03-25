//
//  CAEAGLLayerView.m
//  CoreAnimation
//
//  Created by 杜玉伟 on 2019/3/25.
//  Copyright © 2019年 杜玉伟. All rights reserved.
//

#import "CAEAGLLayerView.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES3/gl.h>
#import <GLKit/GLKit.h>

@interface  CAEAGLLayerView ()

/** context */
@property (nonatomic, strong) EAGLContext *glContext;

/** layer */
@property (nonatomic, strong) CAEAGLLayer *glLayer;

/** framebuffer */
@property (nonatomic, assign) GLuint framebuffer;

/** renderbuffer */
@property (nonatomic, assign) GLuint renderbuffer;

/** width */
@property (nonatomic, assign) GLint framebufferWidth;

/** height */
@property (nonatomic, assign) GLint framebufferHeight;

/** effect */
@property (nonatomic, strong) GLKBaseEffect *effect;


@end

@implementation CAEAGLLayerView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupBuffers];
        [self drawFrame];
    }
    return self;
}



- (void)setupBuffers {
    self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    [EAGLContext setCurrentContext:self.glContext];
    
    self.glLayer = [CAEAGLLayer layer];
    self.glLayer.frame = self.bounds;
    [self.layer addSublayer:self.glLayer];
    self.glLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking : @NO, kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8};
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    
    glGenRenderbuffers(1, &_renderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderbuffer);
    [self.glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.glLayer];
    
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_framebufferWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_framebufferHeight);
    
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"fail");
    }
}

- (void)tearDownBuffers {
    if (_framebuffer) {
        glDeleteBuffers(1, &_framebuffer);
        _framebuffer = 0;
    }
    
    if (_renderbuffer) {
        glDeleteBuffers(1, &_renderbuffer);
        _renderbuffer = 0;
    }
}

- (void)drawFrame {
    //viewport
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glViewport(0, 0, _framebufferWidth, _framebufferHeight);
    
    //shader progrem
    [self.effect prepareToDraw];
    
    //clear
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(0, 0, 0, 1.0);
    
    //vertices
    GLfloat vertices[] =  {
        -0.5f, -0.5f, -1.0f,
        0.0f, 0.5f, -1.0f,
        0.5f, -0.5f, -1.0f,
    };
    GLfloat colors[] = {
        0.0f, 0.0f, 1.0f, 1.0f,
        0.0f, 1.0f, 0.0f, 1.0f,
        1.0f, 0.0f, 0.0f, 1.0f,
    };
    
    //draw
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, vertices);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, colors);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    //present
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    [self.glContext presentRenderbuffer:GL_RENDERBUFFER];
    
}

- (void)dealloc {
    [self tearDownBuffers];
    [EAGLContext setCurrentContext:nil];
}

@end
