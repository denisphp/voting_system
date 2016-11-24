<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class AuthController extends Controller
{
    /**
     * @Route("/auth/signup", name="signup")
     *
     * @param Request $request
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function signupAction(Request $request)
    {
        return $this->render('auth/signup.html.twig', []);
    }

    /**
     * @Route("auth/login", name="login")
     *
     * @param Request $request
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function loginAction(Request $request)
    {
        return $this->render('auth/login.html.twig', []);
    }
}